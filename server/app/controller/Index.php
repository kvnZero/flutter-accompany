<?php
namespace app\controller;

use app\BaseController;
use app\model\User;
use app\model\Code;

class Index extends BaseController
{
    public function index()
    {
        return '<style type="text/css">*{ padding: 0; margin: 0; } div{ padding: 4px 48px;} a{color:#2E5CD5;cursor: pointer;text-decoration: none} a:hover{text-decoration:underline; } body{ background: #fff; font-family: "Century Gothic","Microsoft yahei"; color: #333;font-size:18px;} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.6em; font-size: 42px }</style><div style="padding: 24px 48px;"> <h1>:) 2020新春快乐</h1><p> ThinkPHP V' . \think\facade\App::version() . '<br/><span style="font-size:30px;">14载初心不改 - 你值得信赖的PHP框架</span></p><span style="font-size:25px;">[ V6.0 版本由 <a href="https://www.yisu.com/" target="yisu">亿速云</a> 独家赞123助发布 ]</span></div><script type="text/javascript" src="https://tajs.qq.com/stats?sId=64890268" charset="UTF-8"></script><script type="text/javascript" src="https://e.topthink.com/Public/static/client.js"></script><think id="ee9b1aa918103c4fc"></think>';
    }

    public function hello($name = 'ThinkPHP6')
    {
        return 'hello,' . $name;
    }

    public function login()
    {
        $request = request();
        $username = $request->param('username');
        $password = $request->param('password');
        $user = $this->v_hasUser($username);
        if($user == NULL){
            return json($data=['message'=>'not found'],$code=404);
        }
        if($user->password == $password){
            $user->usertoken = (String) random_int(10000,99999);
            if($request->param('latitude') && $request->param('longitude')){
                //如果有值
                $user->latitude = $request->param('latitude');
                $user->longitude = $request->param('longitude');
            }
            $user->save();
            unset($user['password']);
            return json($data=['message'=>'succeed login','user'=>$user]);
        }else{
            return json($data=['message'=>'password error'],$code=400);
        }
    }

    public function token()
    {
        $request = request();
        $token = $request->param('token');
        $user = User::where('usertoken',$token)->find();
        if($user == NULL){
            return json($data=['message'=>'token not found'], $code=404);
            // exit(json_encode(['code'=>400,'message'=>'error']));
        }
        if((time()-strtotime($user->update_time))<604800){
            //未超过一周
            if($request->param('latitude') && $request->param('longitude')){
                //如果有值
                $user->latitude = $request->param('latitude');
                $user->longitude = $request->param('longitude');
                $user->save();
            }
            unset($user['password']);
            return json($data=['message'=>'succeed login','user'=>$user], $code=200);
        }else{
            //超过一周需要重新登陆
            return json($data=['message'=>'back token'],$code=401);
        }
    }

    public function check(String $phone){
        if($this->v_hasUser($phone)==false){
            return json($data=['exist'=>false],$code=200);
        }else{
            return json($data=['exist'=>true],$code=200);
        }
    }

    public function sendcode(String $phone){
        $code = Code::where('phone',$phone)
        ->whereTime('update_time','-1 hours')
        ->order('update_time', 'desc')
        ->find();
        if($code==null){
            $newcode = random_int(100000,999999);
            $code = new Code;
            $code->phone = $phone;
            $code->code = $newcode;
            $code->save();
        }
        // return json($data=['message'=>"succeed send"],$code=200);
        return json($data=['code'=>$code->code],$code=200);
    }

    public function reg()
    {
        $request = request();
        $code = Code::where('phone',$request->param('username'))
        ->where('code',$request->param('code'))
        ->whereTime('update_time','-1 hours')
        ->order('update_time', 'desc')
        ->find();
        if($code==null){
            return json($data=['message'=>'error code'], $code=200);
        }
        $code->delete();
        if($this->v_hasUser($request->param('username'))!=false){
            return json($data=['message'=>'phone is exist'],$code=400);
        }
        $user = new User;
        $user->username = $request->param('username');
        $user->nickname = $request->param('username');
        $user->password = $request->param('password');
        if($user->save()){
            return json($data=['message'=>'succeed reg','user'=>$user], $code=200);
        }else{
            return json($data=['message'=>'error reg','user'=>$user], $code=200);
        }
    }

    public function find()
    {
        $request = request();
        $code = Code::where('phone',$request->param('username'))
        ->where('code',$request->param('code'))
        ->whereTime('update_time','-1 hours')
        ->order('update_time', 'desc')
        ->find();
        if($code==null){
            return json($data=['message'=>'error code'], $code=200);
        }
        $code->delete();
        $user = $this->v_hasUser($request->param('username'));
        if($user==false){
            return json($data=['message'=>'error phone'],$code=200);
        }
        $user->password = $request->param('password');
        if($user->save()){
            return json($data=['message'=>'succeed find'], $code=200);
        }else{
            return json($data=['message'=>'error find'], $code=200);
        }
    }

    public function userinfo(String $id){
        $user = User::where('id',$id)->find();
        if($user==null){
            return json($data=[], $code=404);
        }
        return json($data=['avater'=>$user['avater'],'nickname'=>$user['nickname']], $code=200);
    }

    public function v_hasUser(String $username)
    {
        $user = User::where('username',$username)->find();
        return $user==Null ? false : $user;
    }
    
}
