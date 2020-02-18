<?php
declare (strict_types = 1);

namespace app\model;

use think\Model;

/**
 * @mixin think\Model
 */
class Good extends Model
{
    public function User()
    {
        return $this->hasOne(User::class,'id','user_id');
    }
}
