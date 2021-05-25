<?php
declare(strict_types=1);

namespace App\Controller\Admin;

use App\Exception\Exception as AppException;
use Cake\Log\Log;

class TopicsController extends AdminController {
  public function initialize(): void {
    parent::initialize();
  }

  public function create() {
    $topic = null;

    if ($this->request->is(['post'])) {
      try {
        $topic = $this->Topics->newEntity([
          'title' => $this->request->getData('title'),
        ]);

        $topicSaved = $this->Topics->save($topic);

        if (!$topicSaved) {
          throw new AppException(sprintf('Failed to save Topic. (%s)', json_encode([
            'topic' => $topic,
          ])));
        }

        $this->Flash->success(__('トピックを保存しました。'));

        return $this->redirect([
          'action' => 'index',
        ]);
      } catch (AppException $exception) {
        $this->Flash->error(__('トピックを保存できませんでした。'));

        Log::error(sprintf('[Admin.TopicsController::create] %s', $exception->getMessage()));
      }
    }

    $this->set(compact([
      'topic',
    ]));
  }

  public function index() {
    $topics = $this->Topics->find()
        ->order([
          'Topics.title' => 'asc',
        ])
        ->toList();

    $this->set(compact([
      'topics',
    ]));
  }

  public function update($id) {
    $topic = $this->Topics->find()
        ->where([
          ['Topics.id' => $id],
        ])
        ->first();

    if (empty($topic)) {
      $this->Flash->error(__('トピックが見つかりませんでした。'));
    }

    if ($this->request->is(['put'])) {
      try {
        $this->Topics->patchEntity($topic, [
          'title' => $this->request->getData('title'),
        ]);

        $topicSaved = $this->Topics->save($topic);

        if (!$topicSaved) {
          throw new AppException(sprintf('Failed to save Topic. (%s)', json_encode([
            'topic' => $topic,
          ])));
        }

        $this->Flash->success(__('トピックを保存しました。'));

        return $this->redirect([
          'action' => 'index',
        ]);
      } catch (AppException $exception) {
        $this->Flash->error(__('トピックを保存できませんでした。'));

        Log::error(sprintf('[Admin.TopicsController::update] %s', $exception->getMessage()));
      }
    }

    $this->set(compact([
      'topic',
    ]));
  }

  public function delete($id) {
    if ($this->request->is(['delete'])) {
      try {
        $topic = $this->Topics->find()
            ->where([
              ['Topics.id' => $id],
            ])
            ->first();

        if (empty($topic)) {
          throw new AppException(sprintf('Failed to find Topic. (%s)', json_encode([
            'id' => $id,
          ])));
        }

        $topicDeleted = $this->Topics->delete($topic);

        if (!$topicDeleted) {
          throw new AppException(sprintf('Failed to delete Topic. (%s)', json_encode([
            'topic' => $topic,
          ])));
        }

        $this->Flash->success(__('トピックを削除しました。'));
      } catch (AppException $exception) {
        $this->Flash->error(__('トピックを削除できませんでした。'));

        Log::error(sprintf('[Admin.TopicsController::delete] %s', $exception->getMessage()));
      }
    }

    return $this->redirect([
      'action' => 'index',
    ]);
  }
}

