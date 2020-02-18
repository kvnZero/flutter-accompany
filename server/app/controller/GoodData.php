<?php
namespace app\controller;

use app\BaseController;
use app\model\Good;

class GoodData extends BaseController
{
    public function getList($type=0)
    {
        $request = request();
        $page = $request->param('page') ? $request->param('page') : 0;
        $maxcount = $request->param('count') ? $request->param('count') : 10;
        $lastid = $request->param('lastid') ? $request->param('lastid') : -1;
        $result = Good::withJoin([
            'user' => ['id','nickname','avater']
        ])->select();
        $data=[];
        foreach ($result as $key) {
            $key['good_imgurl'] = json_decode($key['good_imgurl']);
            $data[] = $key;
        }
        return json($data=$data, $code=200);
    }
}
