<?php

namespace think\swoole\websocket\socketio;

use Swoole\Server;
use Swoole\Websocket\Frame;
use Swoole\WebSocket\Server as WebsocketServer;
use think\Config;
use think\Request;
use think\swoole\contract\websocket\HandlerInterface;

class Handler implements HandlerInterface
{
    /** @var WebsocketServer */
    protected $server;

    /** @var Config */
    protected $config;

    /** @var userarr */
    protected array $userarr;

    public function __construct(Server $server, Config $config)
    {
        $this->userarr = array();
        $this->server = $server;
        $this->config = $config;
    }

    /**
     * "onOpen" listener.
     *
     * @param int     $fd
     * @param Request $request
     */
    public function onOpen($fd, Request $request)
    {
        if($request->param('userid')){
            $this->userarr[$request->param('userid')] = $fd;
            if (!$request->param('sid')) {
                $payload        = json_encode(
                    [
                        'sid'          => base64_encode(uniqid()),
                        'upgrades'     => [],
                        'pingInterval' => $this->config->get('swoole.websocket.ping_interval'),
                        'pingTimeout'  => $this->config->get('swoole.websocket.ping_timeout'),
                    ]
                );
                $initPayload    = Packet::OPEN . $payload;
                $connectPayload = Packet::MESSAGE . Packet::CONNECT;
    
                $this->server->push($fd, $initPayload);
                $this->server->push($fd, $connectPayload);
            }
            print_r($this->userarr);
        }
    }

    /**
     * "onMessage" listener.
     *  only triggered when event handler not found
     *
     * @param Frame $frame
     * @return bool
     */
    public function onMessage(Frame $frame)
    {

        $packet = $frame->data;
        // if (Packet::getPayload($packet)) {
        //     return false;
        // }
        if(substr($packet,4,7)=='message'){
            $text = substr($packet,13);
            $json_m = json_decode(substr($text,0,strlen($text)-1));
            if(array_key_exists($json_m->toid,$this->userarr)){
                $this->server->push($this->userarr['toid'], '42["message",{"msg":'.$json_m->msg.',"fromid":'.$json_m->fromid.',"mid":'.$json_m->mid.',"toid":'.$json_m->toid.',"time":'.$json_m->time.'}]');
            }
            // $this->server->push($this->userarr['formid'], '42["message",{"msg":'.json_encode($message).'}]');
        }
        // $this->checkHeartbeat($frame->fd, $packet);
        return true;
    }

    /**
     * "onClose" listener.
     *
     * @param int $fd
     * @param int $reactorId
     */
    public function onClose($fd, $reactorId)
    {
        $msg =  array_search($fd,$this->userarr);
        if($msg != false){
            unset($this->userarr[$msg]);
        }
        return;
    }

    protected function checkHeartbeat($fd, $packet)
    {
        $packetLength = strlen($packet);
        $payload      = '';
        print("send");

        if ($isPing = Packet::isSocketType($packet, 'ping')) {
            $payload .= Packet::PONG;
        }

        if ($isPing && $packetLength > 1) {
            $payload .= substr($packet, 1, $packetLength - 1);
        }

        if ($isPing) {
            print("ping");
            $this->server->push($fd, $payload);
        }
    }
}
