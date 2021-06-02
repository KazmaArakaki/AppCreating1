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

    $this->Paginator->setTemplates([
      'nextActive' => '<li class="page-item"><a href="{{url}}" class="page-link">{{text}}</a></li>',
      'nextDisabled' => '<li class="page-item disabled"><span class="page-link">{{text}}</span></li>',
      'prevActive' => '<li class="page-item"><a href="{{url}}" class="page-link">{{text}}</a></li>',
      'prevDisabled' => '<li class="page-item disabled"><span class="page-link">{{text}}</span></li>',
      'first' => '<li class="page-item"><a href="{{url}}" class="page-link">{{text}}</a></li>',
      'last' => '<li class="page-item"><a href="{{url}}" class="page-link">{{text}}</a></li>',
      'number' => '<li class="page-item"><a href="{{url}}" class="page-link">{{text}}</a></li>',
      'current' => '<li class="page-item active"><span class="page-link">{{text}}</span></li>',
      'ellipsis' => '<li class="page-item disabled"><span class="page-link">&hellip;</span></li>',
    ]);
  }
}

