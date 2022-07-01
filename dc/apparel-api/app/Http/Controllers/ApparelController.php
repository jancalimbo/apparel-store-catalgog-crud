<?php

namespace App\Http\Controllers;

use App\Models\Apparel;
use Illuminate\Http\Request;

class ApparelController extends Controller
{


    // CRUD - READ

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

        return response()->json(Apparel::orderBy('id','DESC')->get());

    }




    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        $apparel = Apparel::create($request->all());

        return response()->json([
            'status' => true,
            'message' => "Post Created successfully!",
            'post' => $apparel
        ], 200);

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Apparel  $apparel
     * @return \Illuminate\Http\Response
     */
    public function show(Apparel $apparel)
    {
        return response()->json($apparel);
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Apparel  $apparel
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Apparel $apparel)
    {
        $apparel->update($request->all());

        return response()->json([
            'status' => true,
            'message' => "Post Updated successfully!",
            'post' => $apparel
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Apparel  $apparel
     * @return \Illuminate\Http\Response
     */
    public function destroy(Apparel $apparel)
    {
        $apparel->delete();

        return response()->json([
            'status' => true,
            'message' => "Apparel Deleted successfully!",
            'post' => $apparel
        ], 200);
    }
}

