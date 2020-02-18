<?php
namespace app\controller;

use app\BaseController;
use app\model\Message;
use think\facade\Db;
class MessageData extends BaseController
{
    public function getAllMessage()
    {
        $request = request();
        $token = $request->param('token') ? $request->param('token') : 0;
        if($token == 0){
            return json($data=['msg'=>'error token'], $code=200);
        }
        $result = Message::where('message.id','>',request()->param('lastid')?request()->param('lastid'):0)->where('message.fromid|message.toid', 'IN', function ($query) {
            $query->table('user')->where('usertoken',request()->param('token'))->field('id');
        })->withJoin([
            'user' => ['id','nickname','avater'],
        ],'LEFT')->select(); 
        $data=[];
        foreach ($result as $key) {
            $data[] = $key;
        }
        return json($data=$data, $code=200);
    }

    public function getList()
    {
        $request = request();
        $token = $request->param('token') ? $request->param('token') : 0;
        if($token == 0){
            return json($data=['msg'=>'error token'], $code=200);
        }
        $result = Message::where('message.id', 'IN', function ($query) {
            $query->table('message')->where('message.id','>',request()->param('lastid')?request()->param('lastid'):0)->where('message.fromid|message.toid', 'IN', function ($query) {
                $query->table('user')->where('usertoken',request()->param('token'))->field('id');
            })->field('max(id)')->group('fromid,toid');
        })->withJoin([
            'user' => ['id','nickname','avater'],
        ],'LEFT')->select(); 
        $data=[];
        foreach ($result as $key) {
            $data[] = $key;
        }
        return json($data=$data, $code=200);
    }

    public function sendmessage()
    {
        $request = request();
        $message = new Message;
        $message->fromid=$request->param('fromid') ;
        $message->toid=$request->param('toid');
        $message->content=$request->param('msg');
        $message->read=1;
        $message->save();
        if($message->id){
            return json($data=$message, $code=200);
        }else{
            return json($data=[], $code=200);
        }
    }
}
