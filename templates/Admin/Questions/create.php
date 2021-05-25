<?= $this->Form->create($question, ['novalidate' => true]) ?>
  <div class="mb-3">
    <label class="form-label">
      <?= __('タイトル') ?>
    </label>

    <?= $this->Form->text('title', [
      'class' => implode(' ', [
        'form-control',
        $this->Form->isFieldError('title') ? 'is-invalid' : '',
      ]),
    ]) ?>

    <?= $this->Form->error('title') ?>

    <div class="form-text">
      <?= __('親決め質問のタイトルです') ?>
    </div>
  </div>

  <button class="btn btn-primary">
    <?= __('決定') ?>
  </button>
<?= $this->Form->end() ?>

