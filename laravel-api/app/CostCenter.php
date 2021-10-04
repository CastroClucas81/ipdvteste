<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class CostCenter extends Model
{
    protected $table = 'cost_centers';
    protected $primaryKey = 'cost_center_id';
    public $timestamps = true;

    protected $fillable = [
        'description'
    ];
}
