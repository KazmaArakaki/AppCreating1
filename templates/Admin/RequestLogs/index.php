<?php $this->start('pagination'); ?>
<nav class="d-flex justify-content-end my-4">
  <ul class="pagination">
    <?= $this->Paginator->prev('<') ?>

    <?= $this->Paginator->numbers([
      'first' => 1,
      'modulus' => 2,
      'last' => 1,
    ]) ?>

    <?= $this->Paginator->next('>') ?>
  </ul>
</nav>
<?php $this->end(); ?>

<?= $this->fetch('pagination') ?>

<div class="table-responsive my-4">
  <table class="table table-bordered table-striped table-hover table-sm">
    <thead>
      <tr>
        <th>
          <?= 'Datetime' ?>
        </th>

        <th>
          <?= 'Request Path' ?>
        </th>

        <th>
          <?= 'Request Query' ?>
        </th>

        <th>
          <?= 'Request Data' ?>
        </th>

        <th>
          <?= 'Device' ?>
        </th>

        <th>
          <?= 'App Version' ?>
        </th>

        <th>
          <?= 'Timezone' ?>
        </th>

        <th>
          <?= 'IP' ?>
        </th>
      </tr>
    </thead>

    <tbody>
      <?php foreach ($requestLogs as $requestLog): ?>
      <tr>
        <td class="text-nowrap">
          <?= $requestLog['created']->i18nFormat('yyyy/MM/dd HH:mm', 'Asia/Tokyo') ?>
        </td>

        <td class="text-nowrap">
          <?= h($requestLog['request_path']) ?>
        </td>

        <td class="text-nowrap">
          <?= sprintf('Length: %d', mb_strlen($requestLog['request_query'])) ?>
        </td>

        <td class="text-nowrap">
          <?= sprintf('Length: %d', mb_strlen($requestLog['request_data'])) ?>
        </td>

        <td class="text-nowrap">
          <?= vsprintf('%s (%s)', [
            h($requestLog['name']),
            h($requestLog['os']),
          ]) ?>
        </td>

        <td class="text-nowrap">
          <?= h($requestLog['app_version']) ?>
        </td>

        <td class="text-nowrap">
          <?= h($requestLog['timezone']) ?>
        </td>

        <td class="text-nowrap">
          <?= h($requestLog['ip']) ?>
        </td>
      </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
</div>

<?= $this->fetch('pagination') ?>

