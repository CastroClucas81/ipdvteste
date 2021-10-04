<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('office_idfk');
            $table->unsignedBigInteger('departament_idfk');
            $table->string('name');
            $table->string('email');
            $table->string('password');
            $table->timestamps();

            $table->foreign('departament_idfk')->on('departaments')->references('departament_id')->cascadeOnDelete();
            $table->foreign('office_idfk')->on('offices')->references('office_id')->cascadeOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
