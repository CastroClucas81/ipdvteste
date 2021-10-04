<?php

namespace App\Http\Controllers;

use App\CostCenter;
use App\Http\Requests\CostCenterRequest;
use Illuminate\Http\Request;

class CostCenterController extends Controller
{
    public function store(CostCenterRequest $request)
    {
        try {
            $costCenter = new CostCenter;
            $costCenter->description = request()->description;

            $costCenter->save();

            return response()->json("Cadastrado com sucesso!");
        } catch (\Throwable $th) {
            return response()->json($th);
        }
    }

    public function delete(CostCenterRequest $request)
    {
        $costCenter = CostCenter::where('cost_center_id', request()->id);

        if (!is_null($costCenter)) {
            $costCenter->delete();
            return response()->json("Centro de custo deletado com sucesso!");
        } else {
            return response()->json("Erro ao tentar deletar o cetro de custo!");
        }
    }

    public function getAll()
    {
        $costCenter = CostCenter::all();
        return json_encode($costCenter);
    }

    public function edit(CostCenterRequest $request)
    {

        $cost_center = CostCenter::where('cost_center_id', request()->cost_center_id)->first();
        $cost_center->description = request()->description;
        if ($cost_center->save()) return response()->json("Centro de custo editado com sucesso!");
        else return response()->json("Erro ao Editar!");
    }

    public function allCostsCentersPaginate()
    {
        $costsCenters = CostCenter::paginate(3);
        return response()->json($costsCenters);
    }
}
