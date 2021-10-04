<?php

namespace App\Http\Controllers;

use App\Departament;
use App\Http\Requests\UserRequest;
use App\Office;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function store(UserRequest $request)
    {

        $user = new User;

        $user->office_idfk = request()->office_idfk;
        $user->departament_idfk = request()->departament_idfk;
        $user->name = request()->name;
        $user->email = request()->email;
        $user->password = Hash::make(request()->password);
        $user->save();

        return response()->json("Cadastrado com sucesso!");
    }

    public function getDepartamentUser(int $id)
    {
        $departament = Departament::where('departament_id', '=', $id)->get();

        return $departament;
    }

    public function getOfficeUser(int $id)
    {
        $office = Office::where('office_id', '=', $id)->get();

        return $office;
    }

    public function delete(UserRequest $request)
    {
        $user = User::find(request()->id);

        if (!is_null($user)) {
            $user->delete();
            return response()->json("Usuário deletado com sucesso!");
        } else {
            return response()->json("Erro ao tentar deletar o usuário!");
        }
    }

    public function userForDepartament()
    {
        $users = User::select("users.*", "departaments.description")
            ->leftJoin("departaments", "departament_id", "=", "departament_idfk")
            ->paginate(8);

        return response()->json($users->groupBy("departament_idfk"));
    }

    public function usersAll()
    {
        $users = User::all();
        return response()->json($users);
    }

    public function edit(UserRequest $request)
    {
        $user = User::find(request()->user_id);
        $user->office_idfk = request()->office_idfk;
        $user->departament_idfk = request()->departament_idfk;
        $user->name = request()->name;
        $user->email = request()->email;
        $user->password = Hash::make(request()->password);
        if ($user->save()) return response()->json("Usuário editado com sucesso!");
        else return response()->json("Erro ao Editar!");
    }

    public function import(Request $request)
    {
        try {
            if ($request->hasFile('file')) {
                $file = $request->file('file');
                $csv = array_map('str_getcsv', file($file));

                foreach ($csv as $line) {
                    $user = new User;
                    $user->office_idfk = $line[0];
                    $user->departament_idfk = $line[1];
                    $user->name = $line[2];
                    $user->email = $line[3];
                    $user->password = Hash::make($line[4]);
                    $user->save();
                }
                return response()->json("Usuários cadastrados com sucesso!");
            }
        } catch (\Throwable $th) {
            return response()->json("Erro ao cadastrar o usuário!");
        }
    }
}
