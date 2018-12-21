<?php

namespace  App\Tests\Controller;

use App\Conntrolle\MediaController;
use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;
use PHPUnit\Framework\TestCase;


class MediaControllerTest extends  TestCase
{

    public function testGetMedia()
    {

        $client = static::createClient();
        $client->request('GET', '/media/api');
        $this->assertEquals(200,
            $client->getResponse()->getStatusCode());

    }
}