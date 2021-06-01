<?php
use Cake\Core\Configure;

$pageTitle = !empty($this->fetch('pageTitle')) ? implode(' | ', [
  $this->fetch('pageTitle'),
  Configure::read('App.serviceName'),
]) : Configure::read('App.serviceName');
?>
<?php $this->append('pageContent'); ?>
<div>
  <header class="navbar navbar-expand navbar-dark bg-dark">
    <nav class="container">
      <a class="navbar-brand" href="<?= $this->Url->build([
        'controller' => 'Home',
        'action' => 'index',
      ]) ?>">
        <?= Configure::read('App.serviceName') ?>
      </a>

      <?php if (!empty($authAdministrator)): ?>
      <div class="collapse navbar-collapse">
        <ul class="navbar-nav me-auto">
          <li class="nav-item">
            <a href="<?= $this->Url->build([
              'controller' => 'Topics',
              'action' => 'index',
            ]) ?>" class="nav-link <?= $this->request->getParam('controller') === 'Topics' ? 'active' : '' ?>">
              <?= __('トピック') ?>
            </a>
          </li>

          <li class="nav-item">
            <a href="<?= $this->Url->build([
              'controller' => 'Questions',
              'action' => 'index',
            ]) ?>" class="nav-link <?= $this->request->getParam('controller') === 'Questions' ? 'active' : '' ?>">
              <?= __('親決め質問') ?>
            </a>
          </li>

          <li class="nav-item">
            <a href="<?= $this->Url->build([
              'controller' => 'RequestLogs',
              'action' => 'index',
            ]) ?>" class="nav-link <?= $this->request->getParam('controller') === 'RequestLogs' ? 'active' : '' ?>">
              <?= __('リクエストログ') ?>
            </a>
          </li>

          <li class="nav-item">
            <a href="<?= $this->Url->build([
              'controller' => 'Administrators',
              'action' => 'index',
            ]) ?>" class="nav-link <?= $this->request->getParam('controller') === 'Administrators' ? 'active' : '' ?>">
              <?= __('管理者') ?>
            </a>
          </li>
        </ul>

        <a href="<?= $this->Url->build([
          'controller' => 'Administrators',
          'action' => 'signOut',
        ]) ?>" class="btn btn-outline-secondary">
          <?= __('サインアウト') ?>
        </a>
      </div>
      <?php endif; ?>
    </nav>
  </header>

  <div class="my-4">
    <div class="container">
      <?= $this->Flash->render() ?>
    </div>
  </div>

  <div class="my-4">
    <div class="container">
      <h1 class="h3">
        <?= h($this->request->getParam('controller')) ?>

        <small class="text-secondary">
          <?= h($this->request->getParam('action')) ?>
        </small>
      </h1>
    </div>
  </div>

  <div class="my-4">
    <div class="container">
      <?= $this->fetch('content') ?>
    </div>
  </div>

  <?= $this->element('footer') ?>
</div>
<?php $this->end(); ?>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>
      <?= $pageTitle ?>
    </title>

    <?= $this->fetch('meta') ?>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" crossorigin="anonymous" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1">

    <?= $this->fetch('css') ?>

    <?= $this->fetch('component') ?>
  </head>

  <body>
    <?= $this->fetch('pageContent') ?>

    <?= $this->fetch('modal') ?>

    <?= $this->fetch('postLink') ?>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"></script>

    <?= $this->fetch('script') ?>
  </body>
</html>

