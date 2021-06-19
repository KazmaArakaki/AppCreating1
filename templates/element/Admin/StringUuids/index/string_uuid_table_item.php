<?php
$localizedStringLanguageIdMap = collection($stringUuid['localized_strings'])
    ->indexBy('language_id')
    ->toArray();
?>

<tr
    data-element-name="string-uuid-table-item">
  <td>
    <div>
      <a href="<?= $this->Url->build([
        'controller' => 'LocalizedStrings',
        'action' => 'index',
        'stringUuidId' => $stringUuid['id'],
      ]) ?>">
        <?= h($stringUuid['uuid']) ?>
      </a>
    </div>

    <small class="d-block">
      <?= h($stringUuid['description']) ?>
    </small>

    <div class="toggle-buttons-container">
      <?php foreach ($languages as $language): ?>
      <?php if (!empty($localizedStringLanguageIdMap[$language['id']])): ?>
      <button class="btn btn-sm btn-outline-success py-0" style="<?= $this->Html->style([
        'font-size' => '12px',
      ]) ?>"
          data-language-id="<?= $language['id'] ?>">
        <?= h($language['name']) ?>
      </button>
      <?php endif; ?>
      <?php endforeach; ?>
    </div>

    <div class="localized-string-items-container">
      <?php foreach ($localizedStringLanguageIdMap as $languageId => $localizedString): ?>
      <small class="d-block d-none"
          data-language-id="<?= $languageId ?>">
        <?= nl2br(h($localizedString['value'])) ?>
      </small>
      <?php endforeach; ?>
    </div>
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

<?php if (!$this->exists('string_uuid_table_item_script')): ?>
<?php $this->start('string_uuid_table_item_script'); ?>
<script>
window.addEventListener("DOMContentLoaded", (event) => {
  const stringUuidTableItems = document.querySelectorAll(`[data-element-name="string-uuid-table-item"]`);

  for (const stringUuidTableItem of stringUuidTableItems) {
    const toggleButtons = stringUuidTableItem.querySelectorAll(".toggle-buttons-container button");
    const localizedStringItemsContainer = stringUuidTableItem.querySelector(".localized-string-items-container");

    for (const toggleButton of toggleButtons) {
      toggleButton.addEventListener("click", (event) => {
        for (const toggleButton of toggleButtons) {
          toggleButton.classList.remove("btn-success");
          toggleButton.classList.add("btn-outline-success");
        }

        for (const localizedStringItem of localizedStringItemsContainer.querySelectorAll("small")) {
          localizedStringItem.classList.add("d-none");
        }

        toggleButton.classList.remove("btn-outline-success");
        toggleButton.classList.add("btn-success");

        const languageId = toggleButton.dataset.languageId;
        const localizedStringItem = localizedStringItemsContainer.querySelector(`[data-language-id="${languageId}"]`);

        localizedStringItem.classList.remove("d-none");
      });
    }
  }
});
</script>
<?php $this->end(); ?>
<?php $this->append('script', $this->fetch('string_uuid_table_item_script')); ?>
<?php endif; ?>

