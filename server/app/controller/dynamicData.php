<?php
namespace app\controller;

use app\BaseController;
use app\model\Dynamic;

class DynamicData extends BaseController
{
    public function getList($type=0)
    {
        
        $request = request();
        $page = $request->param('page') ? $request->param('page') : 0;
        $maxcount = $request->param('count') ? $request->param('count') : 10;
        $lastid = $request->param('lastid') ? $request->param('lastid') : -1;
        $result = Dynamic::withJoin([
            'user' => ['id','nickname','avater']
        ])->select();
        $data=[];
        foreach ($result as $key) {
            $key['dynamic_images'] = json_decode($key['dynamic_images']);
            $key['dynamic_video'] = json_decode($key['dynamic_video']);
            $data[] = $key;
            // print($key->user->username."\n");    
        }
        return json($data=$data, $code=200);
    }
}
