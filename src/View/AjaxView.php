<?php
declare(strict_types=1);

namespace App\View;

class AjaxView extends AppView {
  public $layout = 'ajax';

  public function initialize(): void {
    parent::initialize();

    $this->response = $this->response->withType('ajax');
  }
}

