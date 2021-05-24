<?php
use Cake\Core\Configure;

$pageTitle = !empty($this->fetch('pageTitle')) ? implode(' | ', [
  $this->fetch('pageTitle'),
  Configure::read('App.serviceName'),
]) : Configure::read('App.serviceName');
?>
<?php $this->append('pageContent'); ?>
<div>
  <?= $this->element('header') ?>

  <div class="my-4">
    <div class="container">
      <?= $this->Flash->render() ?>
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

