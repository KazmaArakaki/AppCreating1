<div class="row">
  <div class="col-auto">
    <a href="<?= $this->Url->build([
      'action' => 'create',
    ]) ?>" class="btn btn-primary">
      <?= __('追加') ?>
    </a>
  </div>
</div>

<table class="table table-bordered table-striped table-hover table-sm">
  <tbody>
    <?php foreach ($topics as $topic): ?>
    <tr>
      <td>
        <?= h($topic['title']) ?>
      </td>

      <td style="<?= $this->Html->style([
        'width' => '120px',
      ]) ?>">
        <div class="d-grid gap-1">
          <a href="<?= $this->Url->build([
            'action' => 'update',
            $topic['id'],
          ]) ?>" class="btn btn-warning btn-sm py-0">
            <?= __('編集') ?>
          </a>

          <?= $this->Form->postLink(__('削除'), [
            'action' => 'delete',
            $topic['id'],
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

