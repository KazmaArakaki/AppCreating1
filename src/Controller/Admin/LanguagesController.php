<?php
declare(strict_types=1);

namespace App\Controller\Admin;

use App\Exception\Exception as AppException;
use Cake\Log\Log;

class LanguagesController extends AdminController {
  public function initialize(): void {
    parent::initialize();
  }

  public function create() {
    $language = null;

    if ($this->request->is(['post'])) {
      try {
        $language = $this->Languages->newEntity([
          'short_key' => $this->request->getData('short_key'),
          'name' => $this->request->getData('name'),
        ]);

        $languageSaved = $this->Languages->save($language);

        if (!$languageSaved) {
          throw new AppException(sprintf('Failed to save Language. (%s)', json_encode([
            'language' => $language,
          ])));
        }

        $this->Flash->success(__('対応言語を保存しました。'));

        return $this->redirect([
          'action' => 'index',
        ]);
      } catch (AppException $exception) {
        $this->Flash->error(__('対応言語を保存できませんでした。'));

        Log::error(sprintf('[Admin.LanguagesController::create] %s', $exception->getMessage()));
      }
    }

    $this->set(compact([
      'language',
    ]));
  }

  public function index() {
    $languages = $this->Languages->find()
        ->order([
          'Languages.name' => 'asc',
        ])
        ->toList();

    $this->set(compact([
      'languages',
    ]));
  }

  public function update($id) {
    $language = $this->Languages->find()
        ->where([
          ['Languages.id' => $id],
        ])
        ->first();

    if (empty($language)) {
      $this->Flash->error(__('対応言語が見つかりませんでした。'));
    }

    if ($this->request->is(['put'])) {
      try {
        $this->Languages->patchEntity($language, [
          'short_key' => $this->request->getData('short_key'),
          'name' => $this->request->getData('name'),
        ]);

        $languageSaved = $this->Languages->save($language);

        if (!$languageSaved) {
          throw new AppException(sprintf('Failed to save Language. (%s)', json_encode([
            'language' => $language,
          ])));
        }

        $this->Flash->success(__('対応言語を保存しました。'));

        return $this->redirect([
          'action' => 'index',
        ]);
      } catch (AppException $exception) {
        $this->Flash->error(__('対応言語を保存できませんでした。'));

        Log::error(sprintf('[Admin.LanguagesController::update] %s', $exception->getMessage()));
      }
    }

    $this->set(compact([
      'language',
    ]));
  }

  public function delete($id) {
    if ($this->request->is(['delete'])) {
      try {
        $language = $this->Languages->find()
            ->where([
              ['Languages.id' => $id],
            ])
            ->first();

        if (empty($language)) {
          throw new AppException(sprintf('Failed to find Language. (%s)', json_encode([
            'id' => $id,
          ])));
        }

        $languageDeleted = $this->Languages->delete($language);

        if (!$languageDeleted) {
          throw new AppException(sprintf('Failed to delete Language. (%s)', json_encode([
            'language' => $language,
          ])));
        }

        $this->Flash->success(__('対応言語を削除しました。'));
      } catch (AppException $exception) {
        $this->Flash->error(__('対応言語を削除できませんでした。'));

        Log::error(sprintf('[Admin.LanguagesController::delete] %s', $exception->getMessage()));
      }
    }

    return $this->redirect([
      'action' => 'index',
    ]);
  }
}

