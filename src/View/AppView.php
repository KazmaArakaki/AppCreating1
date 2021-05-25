<?php
declare(strict_types=1);

namespace App\View;

use Cake\View\View;

class AppView extends View {
  public function initialize(): void {
    parent::initialize();

    $this->Form->setTemplates([
      'error' => '<div class="invalid-feedback">{{content}}</div>',
    ]);
  }
}

