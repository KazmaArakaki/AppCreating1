<?php
declare(strict_types=1);

namespace App\Model\Entity;

use Cake\Auth\DefaultPasswordHasher;
use Cake\ORM\Entity;

class Administrator extends Entity {
  protected $_accessible = [
    '*' => true,
    'id' => false,
  ];

  protected $_hidden = [
    'auth_password',
  ];

  protected function _setAuthPassword(string $authPassword) {
    if (strlen($authPassword) > 0) {
      $passwordHasher = new DefaultPasswordHasher();

      return $passwordHasher->hash($authPassword);
    }

    return null;
  }
}

