<div class="card mb-4">
  <div class="card-body">
    <h5 class="card-title">
      <?= h($stringUuid['uuid']) ?>
    </h5>

    <p class="card-text">
      <?= nl2br(h($stringUuid['description'])) ?>
    </p>
  </div>
</div>

<div class="row mb-4">
  <div class="col-auto">
    <a href="<?= $this->Url->build([
      'action' => 'create',
      'stringUuidId' => $stringUuid['id'],
    ]) ?>" class="btn btn-primary">
      <?= __('追加') ?>
    </a>
  </div>
</div>

<table class="table table-bordered table-striped table-hover table-sm">
  <tbody>
    <?php foreach ($localizedStrings as $localizedString): ?>
    <tr>
      <td style="<?= $this->Html->style([
        'width' => '120px',
      ]) ?>">
        <?= h($localizedString['language']['name']) ?>
      </td>

      <td>
        <?= h($localizedString['value']) ?>
      </td>

      <td style="<?= $this->Html->style([
        'width' => '120px',
      ]) ?>">
        <div class="d-grid gap-1">
          <a href="<?= $this->Url->build([
            'action' => 'update',
            'stringUuidId' => $stringUuid['id'],
            $localizedString['id'],
          ]) ?>" class="btn btn-warning btn-sm py-0">
            <?= __('編集') ?>
          </a>

          <?= $this->Form->postLink(__('削除'), [
            'action' => 'delete',
            'stringUuidId' => $stringUuid['id'],
            $localizedString['id'],
          ], [
            'block' => true,
            'method' => 'delete',
            'confirm' => __('本当に削除しますか？'),
            'class' => 'btn btn-danger btn-sm py-0',
          ]) ?>
        </div>
      </td>
    </tr>
    <?php endforeach; ?>
  </tbody>
</table>

