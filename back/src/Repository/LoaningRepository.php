<?php

namespace App\Repository;

use App\Entity\Loaning;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Symfony\Bridge\Doctrine\RegistryInterface;

/**
 * @method Loaning|null find($id, $lockMode = null, $lockVersion = null)
 * @method Loaning|null findOneBy(array $criteria, array $orderBy = null)
 * @method Loaning[]    findAll()
 * @method Loaning[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class LoaningRepository extends ServiceEntityRepository
{
    public function __construct(RegistryInterface $registry)
    {
        parent::__construct($registry, Loaning::class);
    }

    public function findAllPast()
    {
      $conn = $this->getEntityManager()->getConnection();

      $sql =
      'SELECT
        loaning.start,
        loaning.end,
        loaning.user
        FROM loaning
        WHERE loaning.end < NOW()'
        ;

      $query = $conn->prepare($sql);
      $query->execute();
      return $query->fetchAll();
    }


}
