<div class="row mb-4">
  <div class="col-auto">
    <a href="<?= $this->Url->build([
      'action' => 'create',
    ]) ?>" class="btn btn-primary">
      <?= __('追加') ?>
    </a>
  </div>
</div>

<div class="card mb-4">
  <div class="card-header">
    <ul class="nav nav-tabs card-header-tabs">
      <li class="nav-item">
        <a href="#" class="nav-link active">
          <?= __('検索') ?>
        </a>
      </li>
    </ul>
  </div>

  <div class="card-body">
    <?= $this->Form->create(null, [
      'novalidate' => true,
      'class' => 'row g-1',
    ]) ?>
      <div class="col">
        <?= $this->Form->text('search_query', [
          'value' => $searchQuery,
          'class' => 'form-control form-control-sm',
        ]) ?>
      </div>

      <div class="col-auto">
        <button type="submit" class="btn btn-primary btn-sm">
          <?= __('検索') ?>
        </button>
      </div>
    <?= $this->Form->end() ?>
  </div>
</div>


<table class="table table-bordered table-striped table-hover table-sm">
  <tbody>
    <?php foreach ($stringUuids as $stringUuid): ?>
    <tr>
      <td>
        <a href="<?= $this->Url->build([
          'controller' => 'LocalizedStrings',
          'action' => 'index',
          'stringUuidId' => $stringUuid['id'],
        ]) ?>" class="d-block">
          <?= h($stringUuid['uuid']) ?>
        </a>

        <small class="d-block">
          <?= h($stringUuid['description']) ?>
        </small>
      </td>

      <td style="<?= $this->Html->style([
        'width' => '120px',
      ]) ?>">
        <div class="d-grid gap-1">
          <a href="<?= $this->Url->build([
            'action' => 'update',
            $stringUuid['id'],
          ]) ?>" class="btn btn-warning btn-sm py-0">
            <?= __('編集') ?>
          </a>

          <?= $this->Form->postLink(__('削除'), [
            'action' => 'delete',
            $stringUuid['id'],
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

