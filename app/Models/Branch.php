<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Branch extends Model
{
    use HasFactory;

    // Specify the table if it's not the plural form of the model name
    protected $table = 'branch';

    // Specify the primary key if it's not 'id'
    protected $primaryKey = 'id';

    // Indicate if the primary key is auto-incrementing
    public $incrementing = true;

    // Specify the data type of the primary key
    protected $keyType = 'int';

    // Enable timestamps
    public $timestamps = true;

    // Specify the fillable attributes for mass assignment
    protected $fillable = [
        'organization_name',
        'branch',
        'address',
        'status',
    ];
}
