<?php

namespace App\Http\Controllers;

use App\Http\Requests\OfficeRequest;
use Illuminate\Http\Request;
use App\Office;

class OfficeController extends Controller
{
    public function getAll() {
        $offices = Office::all();
        return json_encode($offices);
    }

    public function store(OfficeRequest $request)
    {
        $office = new Office;
        $office->description = request()->description;

        if ($office->save()) return response()->json("Cadastrado com sucesso!");
        else return response()->json("Erro ao cadastrar!");
    }

    public function delete(OfficeRequest $request)
    {

        $office = Office::where('office_id',request()->id);

        if (!is_null($office)) {
            $office->delete();
            return response()->json("Cargo deletado com sucesso!");
        } else {
            return response()->json("Erro ao tentar deletar o cargo!");
        }
    }

    public function edit(OfficeRequest $request) {
        $office = Office::find(request()->office_id);
        $office->description = request()->description;
        if ($office->save()) return response()->json("Cargo editado com sucesso!");
        else return response()->json("Erro ao Editar!");
    }

    public function allOfficesPaginate()
    {
        $offices = Office::paginate(3);
        return response()->json($offices);
    }
}
