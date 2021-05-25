<?= $this->Form->create(null, [
  'novalidate' => true,
  'valueSource' => ['data'],
]) ?>
  <div class="mb-3">
    <label class="form-label">
      <?= __('メールアドレス') ?>
    </label>

    <?= $this->Form->text('auth_email', [
      'class' => implode(' ', [
        'form-control',
      ]),
    ]) ?>
  </div>

  <div class="mb-3">
    <label class="form-label">
      <?= __('パスワード') ?>
    </label>

    <?= $this->Form->password('auth_password', [
      'class' => implode(' ', [
        'form-control',
      ]),
    ]) ?>
  </div>

  <button class="btn btn-primary">
    <?= __('サインイン') ?>
  </button>
<?= $this->Form->end() ?>

