<?= $this->Form->create($stringUuid, ['novalidate' => true]) ?>
  <div class="mb-3">
    <label class="form-label">
      <?= __('説明') ?>
    </label>

    <?= $this->Form->textarea('description', [
      'class' => implode(' ', [
        'form-control',
        $this->Form->isFieldError('description') ? 'is-invalid' : '',
      ]),
    ]) ?>

    <?= $this->Form->error('description') ?>

    <div class="form-text">
      <?= __('テキストの補足説明です') ?>
    </div>
  </div>

  <button class="btn btn-primary">
    <?= __('決定') ?>
  </button>
<?= $this->Form->end() ?>

