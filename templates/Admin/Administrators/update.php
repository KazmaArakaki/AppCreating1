<?php debug($this->request->getData()); ?>
<div class="my-2">
  <div class="alert alert-secondary">
    <?= __('更新する項目のみ入力してください。') ?>
  </div>
</div>

<?= $this->Form->create($administrator, [
  'novalidate' => true,
  'valueSources' => ['data'],
]) ?>
  <div class="mb-3">
    <label class="form-label">
      <?= __('メールアドレス') ?>
    </label>

    <?= $this->Form->text('auth_email', [
      'placeholder' => $administrator['auth_email'],
      'class' => implode(' ', [
        'form-control',
        $this->Form->isFieldError('auth_email') ? 'is-invalid' : '',
      ]),
    ]) ?>

    <?= $this->Form->error('auth_email') ?>

    <div class="form-text">
      <?= __('サインインに使用します') ?>
    </div>
  </div>

  <div class="mb-3">
    <label class="form-label">
      <?= __('パスワード') ?>
    </label>

    <?= $this->Form->text('auth_password', [
      'placeholder' => __('設定済みのパスワード'),
      'class' => implode(' ', [
        'form-control',
        $this->Form->isFieldError('auth_password') ? 'is-invalid' : '',
      ]),
    ]) ?>

    <?= $this->Form->error('auth_password') ?>

    <div class="form-text">
      <?= __('サインインに使用します') ?>
    </div>
  </div>

  <div class="mb-3">
    <label class="form-label">
      <?= __('表示名') ?>
    </label>

    <?= $this->Form->text('display_name', [
      'placeholder' => $administrator['display_name'],
      'class' => implode(' ', [
        'form-control',
        $this->Form->isFieldError('display_name') ? 'is-invalid' : '',
      ]),
    ]) ?>

    <?= $this->Form->error('display_name') ?>

    <div class="form-text">
      <?= __('わかりやすい名前を入力してください') ?>
    </div>
  </div>

  <button class="btn btn-primary">
    <?= __('決定') ?>
  </button>
<?= $this->Form->end() ?>

