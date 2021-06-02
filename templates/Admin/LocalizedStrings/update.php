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

<?= $this->Form->create($localizedString, ['novalidate' => true]) ?>
  <div class="mb-3">
    <label class="form-label">
      <?= __('言語') ?>
    </label>

    <?= $this->Form->select('language_id', [
      h($localizedString['language']['id']) => h($localizedString['language']['name']),
    ], [
      'readonly',
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

