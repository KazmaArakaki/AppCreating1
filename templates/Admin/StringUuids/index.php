<?php
$languages = $languageCollection->toList();

$languageNameMapById = $languageCollection->combine('id', 'name')->toArray();
?>

<div class="row my-4">
  <div class="col-auto">
    <span class="btn btn-outline-secondary">
      <?= __('すべて') ?>

      <span class="badge bg-secondary">
        <?= h($stringUuidCount) ?>
      </span>
    </span>
  </div>

  <?php foreach ($localizedStringCountMapByLanguageId as $languageId => $localizedStringCount): ?>
  <div class="col-auto">
    <?= $this->Form->postLink(vsprintf('%s <span class="badge %s">%d</span>', [
      h($languageNameMapById[$languageId]),
      $localizedStringCount['count'] < $stringUuidCount ? 'bg-danger' : 'bg-secondary',
      $localizedStringCount['count'],
    ]), null, [
      'block' => true,
      'data' => [
        'search_query' => $searchQuery,
        'target_language_id' => $languageId,
      ],
      'escape' => false,
      'class' => implode(' ', [
        'btn',
        $localizedStringCount['count'] < $stringUuidCount ? 'btn-outline-danger' : 'btn-outline-secondary',
      ]),
    ]) ?>
  </div>
  <?php endforeach; ?>
</div>

<div class="row my-4">
  <div class="col-auto">
    <a href="<?= $this->Url->build([
      'action' => 'create',
    ]) ?>" class="btn btn-primary">
      <?= __('追加') ?>
    </a>
  </div>
</div>

<div class="card my-4">
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
    <?= $this->Form->create(null, ['novalidate' => true]) ?>
      <div class="row g-1">
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
      </div>

      <div class="row g-1 mt-1">
        <div class="col-auto">
          <div class="input-group input-group-sm">
            <span class="input-group-text">
              <?= __('未ローカライズのみ') ?>
            </span>

            <?= $this->Form->select('target_language_id', $languageNameMapById, [
              'empty' => true,
              'value' => $targetLanguageId,
              'class' => 'form-select',
            ]) ?>
          </div>
        </div>
      </div>
    <?= $this->Form->end() ?>
  </div>
</div>


<table class="table table-bordered table-striped table-hover table-sm">
  <tbody>
    <?php foreach ($stringUuids as $stringUuid): ?>
      <?= $this->element('Admin/StringUuids/index/string_uuid_table_item', [
        'languages' => $languages,
        'stringUuid' => $stringUuid,
      ]) ?>
    <?php endforeach; ?>
  </tbody>
</table>

