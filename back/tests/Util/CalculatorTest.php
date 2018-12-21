<?php

namespace App\Tests\Util;

use App\Util\Calculator;
use PHPUnit\Framework\TestCase;

class CalculatorTest extends TestCase
{

    public function testAdd()
    {

        $calculator  = new Calculator();
        $result = $calculator->add(10, 32);

        $this->assertEquals(41, $result);

    }

    public function testMultiply()
    {

        $calculator  = new Calculator();
        $result = $calculator->Multiply(10, 2);

        $this->assertNotEquals(21, $result);

    }


}