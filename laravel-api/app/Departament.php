<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Departament extends Model
{
    protected $table = 'departaments';
    protected $primaryKey = 'departament_id';
    public $timestamps = true;

    protected $fillable = [
        'description', "cost_center_idfk"
    ];
}
