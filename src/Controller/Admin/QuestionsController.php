<?php
declare(strict_types=1);

namespace App\Controller\Admin;

use App\Exception\Exception as AppException;
use Cake\Log\Log;

class QuestionsController extends AdminController {
  public function initialize(): void {
    parent::initialize();
  }

  public function create() {
    $question = null;

    if ($this->request->is(['post'])) {
      try {
        $question = $this->Questions->newEntity([
          'title' => $this->request->getData('title'),
        ]);

        $questionSaved = $this->Questions->save($question);

        if (!$questionSaved) {
          throw new AppException(sprintf('Failed to save Question. (%s)', json_encode([
            'question' => $question,
          ])));
        }

        $this->Flash->success(__('質問を保存しました。'));

        return $this->redirect([
          'action' => 'index',
        ]);
      } catch (AppException $exception) {
        $this->Flash->error(__('質問を保存できませんでした。'));

        Log::error(sprintf('[Admin.QuestionsController::create] %s', $exception->getMessage()));
      }
    }

    $this->set(compact([
      'question',
    ]));
  }

  public function index() {
    $questions = $this->Questions->find()
        ->order([
          'Questions.title' => 'asc',
        ])
        ->toList();

    $this->set(compact([
      'questions',
    ]));
  }

  public function update($id) {
    $question = $this->Questions->find()
        ->where([
          ['Questions.id' => $id],
        ])
        ->first();

    if (empty($question)) {
      $this->Flash->error(__('質問が見つかりませんでした。'));
    }

    if ($this->request->is(['put'])) {
      try {
        $this->Questions->patchEntity($question, [
          'title' => $this->request->getData('title'),
        ]);

        $questionSaved = $this->Questions->save($question);

        if (!$questionSaved) {
          throw new AppException(sprintf('Failed to save Question. (%s)', json_encode([
            'question' => $question,
          ])));
        }

        $this->Flash->success(__('質問を保存しました。'));

        return $this->redirect([
          'action' => 'index',
        ]);
      } catch (AppException $exception) {
        $this->Flash->error(__('質問を保存できませんでした。'));

        Log::error(sprintf('[Admin.QuestionsController::update] %s', $exception->getMessage()));
      }
    }

    $this->set(compact([
      'question',
    ]));
  }

  public function delete($id) {
    if ($this->request->is(['delete'])) {
      try {
        $question = $this->Questions->find()
            ->where([
              ['Questions.id' => $id],
            ])
            ->first();

        if (empty($question)) {
          throw new AppException(sprintf('Failed to find Question. (%s)', json_encode([
            'id' => $id,
          ])));
        }

        $questionDeleted = $this->Questions->delete($question);

        if (!$questionDeleted) {
          throw new AppException(sprintf('Failed to delete Question. (%s)', json_encode([
            'question' => $question,
          ])));
        }

        $this->Flash->success(__('質問を削除しました。'));
      } catch (AppException $exception) {
        $this->Flash->error(__('質問を削除できませんでした。'));

        Log::error(sprintf('[Admin.QuestionsController::delete] %s', $exception->getMessage()));
      }
    }

    return $this->redirect([
      'action' => 'index',
    ]);
  }
}

