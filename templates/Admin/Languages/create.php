<?= $this->Form->create($language, ['novalidate' => true]) ?>
  <div class="mb-3">
    <label class="form-label">
      <?= __('キー') ?>
    </label>

    <?= $this->Form->text('short_key', [
      'class' => implode(' ', [
        'form-control',
        $this->Form->isFieldError('short_key') ? 'is-invalid' : '',
      ]),
    ]) ?>

    <?= $this->Form->error('short_key') ?>

    <div class="form-text">
      <?= __('対応言語のキーです') ?>
    </div>
  </div>

  <div class="mb-3">
    <label class="form-label">
      <?= __('名前') ?>
    </label>

    <?= $this->Form->text('name', [
      'class' => implode(' ', [
        'form-control',
        $this->Form->isFieldError('name') ? 'is-invalid' : '',
      ]),
    ]) ?>

    <?= $this->Form->error('name') ?>

    <div class="form-text">
      <?= __('対応言語の名前です') ?>
    </div>
  </div>

  <button class="btn btn-primary">
    <?= __('決定') ?>
  </button>
<?= $this->Form->end() ?>

