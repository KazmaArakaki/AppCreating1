<?php
declare(strict_types=1);

namespace App\Exception;

use Cake\Core\Exception\Exception as CakeException;
use Cake\Log\Log;

class Exception extends CakeException {
  public function __construct($message = '', array $options = []) {
    $code = isset($options['code']) ? $options['code'] : null;
    $previous = isset($options['previous']) ? $options['previous'] : null;

    parent::__construct($message, $code, $previous);
  }
}

