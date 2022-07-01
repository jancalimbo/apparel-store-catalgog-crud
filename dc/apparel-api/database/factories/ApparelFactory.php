<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Apparel>
 */
class ApparelFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        return [
            'name'=>$this->faker->name,
            'type'=>$this->faker->randomElement(['shirts','neckwear','sweaters','pajamas']),
            'price'=>$this->faker->numberBetween(100,500),
            'stock'=>$this->faker->numberBetween(100,500),
        ];
    }
}




