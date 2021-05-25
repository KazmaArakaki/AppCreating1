<?php
declare(strict_types=1);

namespace App\Controller\Admin;

use App\Exception\Exception as AppException;
use Cake\Auth\DefaultPasswordHasher;
use Cake\Log\Log;

class AdministratorsController extends AdminController {
  public function initialize(): void {
    parent::initialize();
  }

  public function signIn() {
    if ($this->request->is(['post'])) {
      try {
        $administrator = $this->Administrators->find()
            ->where([
              ['Administrators.auth_email' => $this->request->getData('auth_email')],
            ])
            ->first();

        if (empty($administrator)) {
          throw new AppException(sprintf('Failed to find Administrator. (%s)', json_encode([
            'auth_email' => $this->request->getData('auth_email'),
          ])));
        }

        $passwordHasher = new DefaultPasswordHasher();

        $isPasswordValid = $passwordHasher->check($this->request->getData('auth_password'), $administrator['auth_password']);

        if (!$isPasswordValid) {
          throw new AppException(__('パスワードが正しくありません。'));
        }

        $session = $this->request->getSession();

        $session->write('Admin.Auth.Administrator.id', $administrator['id']);

        $this->Flash->success(__('サインインしました。'));

        $redirect = $session->consume('Admin.Auth.redirect');

        return $this->redirect(!empty($redirect) ? $redirect : [
          'controller' => 'Home',
          'action' => 'index',
        ]);
      } catch (AppException $exception) {
        $this->Flash->error(__('サインインできませんでした。'));

        Log::error(sprintf('[Admin.AdministratorsController::signIn] %s', $exception->getMessage()));
      }
    }
  }

  public function signOut() {
    $session = $this->request->getSession();

    $session->delete('Admin.Auth');

    return $this->redirect([
      'action' => 'signIn',
    ]);
  }

  public function create() {
    $administrator = null;

    if ($this->request->is(['post'])) {
      try {
        $administrator = $this->Administrators->newEntity([
          'auth_email' => $this->request->getData('auth_email'),
          'auth_password' => $this->request->getData('auth_password'),
          'display_name' => $this->request->getData('display_name'),
        ]);

        $administratorWithAuthEmail = $this->Administrators->find()
            ->where([
              ['Administrators.auth_email' => $administrator['auth_email']],
            ])
            ->first();

        if (!empty($administratorWithAuthEmail)) {
          $administrator->setError('auth_email', __('メールアドレスは既に登録されています。'));

          throw new AppException(sprintf('Duplicated Administrator. (%s)', json_encode([
            'auth_email' => $this->request->getData('auth_email'),
          ])));
        }

        $administratorSaved = $this->Administrators->save($administrator);

        if (!$administratorSaved) {
          throw new AppException(sprintf('Failed to save Administrator. (%s)', json_encode([
            'administrator' => $administrator,
          ])));
        }

        $this->Flash->success(__('管理者を保存しました。'));

        return $this->redirect([
          'action' => 'index',
        ]);
      } catch (AppException $exception) {
        $this->Flash->error(__('管理者を保存できませんでした。'));

        Log::error(sprintf('[Admin.AdministratorsController::create] %s', $exception->getMessage()));
      }
    }

    $this->set(compact([
      'administrator',
    ]));
  }

  public function index() {
    $administrators = $this->Administrators->find()
        ->order([
          'Administrators.id' => 'desc',
        ])
        ->toList();

    $this->set(compact([
      'administrators',
    ]));
  }

  public function update($id) {
    $administrator = $this->Administrators->find()
        ->where([
          ['Administrators.id' => $id],
        ])
        ->first();

    if (empty($administrator)) {
      $this->Flash->error(__('管理者が見つかりませんでした。'));
    }

    if ($this->request->is(['put'])) {
      try {
        if (!empty($this->request->getData('auth_email'))) {
          $this->Administrators->patchEntity($administrator, [
            'auth_email' => $this->request->getData('auth_email'),
          ]);
        }

        if (!empty($this->request->getData('auth_password'))) {
          $this->Administrators->patchEntity($administrator, [
            'auth_password' => $this->request->getData('auth_password'),
          ]);
        }

        if (!empty($this->request->getData('display_name'))) {
          $this->Administrators->patchEntity($administrator, [
            'display_name' => $this->request->getData('display_name'),
          ]);
        }

        $administratorSaved = $this->Administrators->save($administrator);

        if (!$administratorSaved) {
          throw new AppException(sprintf('Failed to save Administrator. (%s)', json_encode([
            'administrator' => $administrator,
          ])));
        }

        $this->Flash->success(__('管理者を保存しました。'));

        return $this->redirect([
          'action' => 'index',
        ]);
      } catch (AppException $exception) {
        $this->Flash->error(__('管理者を保存できませんでした。'));

        Log::error(sprintf('[Admin.AdministratorsController::update] %s', $exception->getMessage()));
      }
    }

    $this->set(compact([
      'administrator',
    ]));
  }

  public function delete($id) {
    if ($this->request->is(['delete'])) {
      try {
        $administrator = $this->Administrators->find()
            ->where([
              ['Administrators.id' => $id],
            ])
            ->first();

        if (empty($administrator)) {
          throw new AppException(sprintf('Failed to find Administrator. (%s)', json_encode([
            'id' => $id,
          ])));
        }

        $administratorDeleted = $this->Administrators->delete($administrator);

        if (!$administratorDeleted) {
          throw new AppException(sprintf('Failed to delete Administrator. (%s)', json_encode([
            'administrator' => $administrator,
          ])));
        }

        $this->Flash->success(__('管理者を削除しました。'));
      } catch (AppException $exception) {
        $this->Flash->error(__('管理者を削除できませんでした。'));

        Log::error(sprintf('[Admin.AdministratorsController::delete] %s', $exception->getMessage()));
      }
    }

    return $this->redirect([
      'action' => 'index',
    ]);
  }
}

