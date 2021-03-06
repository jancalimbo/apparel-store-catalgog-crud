<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Apparel extends Model
{
    use HasFactory;
    protected $fillable = ['name','type','price','stock'];
}
