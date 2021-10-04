<?php

namespace App\Http\Controllers;

use App\CostCenter;
use App\Departament;
use App\Http\Requests\DepartamentRequest;

class DepartamentController extends Controller
{
    public function getAll()
    {
        $departaments = Departament::all();
        return json_encode($departaments);
    }

    public function store(DepartamentRequest $request)
    {

        $costCenter = CostCenter::where('cost_center_id', request()->id);

        if (!is_null($costCenter)) {
            $departament = new Departament;
            $departament->cost_center_idfk = request()->cost_center_idfk;
            $departament->description = request()->description;
            $departament->save();

            return response()->json("Cadastrado com sucesso!");
        } else {
            return response()->json("Este centro de custo não existe!");
        }
    }

    public function delete(DepartamentRequest $request)
    {
        $departament = Departament::where('departament_id', request()->id);

        if (!is_null($departament)) {
            $departament->delete();
            return json_encode("Departamento deletado com sucesso!");
        } else {
            return json_encode("Erro ao tentar deletar o departamento!");
        }
    }

    public function departamentForCostCenter()
    {
        $departaments = Departament::all()->groupBy('cost_center_idfk');
        return json_encode($departaments);
    }

    public function edit(DepartamentRequest $request)
    {
        $departament = Departament::find(request()->departament_id);
        $departament->cost_center_idfk = request()->cost_center_idfk;
        $departament->description = request()->description;
        if ($departament->save()) return response()->json("Departamento editado com sucesso!");
        else return response()->json("Erro ao Editar!");
    }

    public function allDepartamentsPaginate()
    {
        $departaments = Departament::select("departaments.*", "cost_centers.description as cost_center_description")
            ->leftJoin("cost_centers", "cost_center_id", "=", "cost_center_idfk")
            ->paginate(8);

        return response()->json($departaments->groupBy("cost_center_idfk"));
    }
}
