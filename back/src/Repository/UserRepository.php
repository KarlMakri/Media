<?php

namespace App\Repository;

use App\Entity\User;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Symfony\Bridge\Doctrine\RegistryInterface;

/**
 * @method User|null find($id, $lockMode = null, $lockVersion = null)
 * @method User|null findOneBy(array $criteria, array $orderBy = null)
 * @method User[]    findAll()
 * @method User[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class UserRepository extends ServiceEntityRepository
{
    public function __construct(RegistryInterface $registry)
    {
        parent::__construct($registry, User::class);
    }

    public function findByPseudoAndToken($pseudo, $token)
    {
      $conn = $this->getEntityManager()->getConnection();

      $sql =
        'SELECT user.id
          FROM user
          WHERE user.pseudo = :pseudo
          AND user.token = :token
          ';

      $query = $conn->prepare($sql);
      $query->execute([':pseudo' => $pseudo, ':token' =>$token]);
      return $query->fetch();
    }

    public function findByPseudoAndPwd($pseudo, $pwd)
    {
      $conn = $this->getEntityManager()->getConnection();

      $sql =
        'SELECT user.id
          FROM user
          WHERE user.pseudo = :pseudo
            AND user.pwd = :pwd
          ';

      $query = $conn->prepare($sql);
      $query->execute([':pseudo' => $pseudo, ':pwd' => $pwd]);
      return $query->fetch();
    }

    public function saveToken($pseudo, $token)
    {
      $conn = $this->getEntityManager()->getConnection();

      $sql =
        'UPDATE user
          SET user.token = :token
          WHERE user.pseudo = :pseudo
          ';

      $query = $conn->prepare($sql);
      return $query->execute([':pseudo' => $pseudo, ':token' => $token]);
    }
}
