<div class="table-responsive">
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
        <td>
          <?= $requestLog['created']->i18nFormat('yyyy/MM/dd HH:mm', 'Asia/Tokyo') ?>
        </td>

        <td>
          <?= h($requestLog['request_path']) ?>
        </td>

        <td>
          <?= sprintf('Length: %d', mb_strlen($requestLog['request_query'])) ?>
        </td>

        <td>
          <?= sprintf('Length: %d', mb_strlen($requestLog['request_data'])) ?>
        </td>

        <td>
          <?= vsprintf('%s (%s)', [
            h($requestLog['name']),
            h($requestLog['os']),
          ]) ?>
        </td>

        <td>
          <?= h($requestLog['app_version']) ?>
        </td>

        <td>
          <?= h($requestLog['timezone']) ?>
        </td>

        <td>
          <?= h($requestLog['ip']) ?>
        </td>
      </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
</div>

