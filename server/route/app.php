<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
use think\facade\Route;

Route::get('think', function () {
    return 'hello,ThinkPHP6!';
});

Route::get('hello/:name', 'index/hello');
Route::post('token', 'index/token');
Route::post('login', 'index/login');
Route::post('reg', 'index/reg');
Route::post('find', 'index/find');
Route::get('code/:phone','index/sendcode');
Route::get('check/:phone','index/check');
Route::get('userinfo/:id', 'index/userinfo');


Route::post('getlist/:type','dynamicData/getlist');

Route::post('getmessagelist','messageData/getlist');
Route::post('getallmessage','messageData/getallmessage');
Route::post('sendmessage','messageData/sendmessage');

Route::post('getgoodlist','GoodData/getlist');
