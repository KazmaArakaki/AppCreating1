<?php
$languageOptions = $languageCollection
    ->order([
      'id' => 'desc',
    ])
    ->combine('id', 'name');
?>

<?= $this->Form->create($localizedString, ['novalidate' => true]) ?>
  <div class="mb-3">
    <label class="form-label">
      <?= __('言語') ?>
    </label>

    <?= $this->Form->select('language_id', $languageOptions, [
      'class' => implode(' ', [
        'form-control',
        $this->Form->isFieldError('language_id') ? 'is-invalid' : '',
      ]),
    ]) ?>

    <?= $this->Form->error('language_id') ?>

    <div class="form-text">
      <?= __('ローカライズ対象の言語です。') ?>
    </div>
  </div>

  <div class="mb-3">
    <label class="form-label">
      <?= __('テキストローカライズ') ?>
    </label>

    <?= $this->Form->textarea('value', [
      'class' => implode(' ', [
        'form-control',
        $this->Form->isFieldError('value') ? 'is-invalid' : '',
      ]),
    ]) ?>

    <?= $this->Form->error('value') ?>

    <div class="form-text">
      <?= __('言語用にローカライズされたテキストです。') ?>
    </div>
  </div>

  <button class="btn btn-primary">
    <?= __('決定') ?>
  </button>
<?= $this->Form->end() ?>

