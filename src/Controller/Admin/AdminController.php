<?php
declare(strict_types=1);

namespace App\Controller\Admin;

use Cake\Controller\Controller;
use Cake\Core\Configure;
use Cake\Event\EventInterface;

class AdminController extends Controller {
  public function initialize(): void {
    parent::initialize();

    $this->loadModel('Administrators');

    $this->loadComponent('RequestHandler');
    $this->loadComponent('Flash');

    Configure::write('App.serviceName', 'AppCreating1 Admin');
  }

  public function beforeFilter(EventInterface $event) {
    parent::beforeFilter($event);

    $session = $this->request->getSession();

    $this->authAdministrator = null;

    if ($session->check('Admin.Auth.Administrator.id')) {
      $this->authAdministrator = $this->Administrators->find()
          ->where([
          ])
          ->first();
    }

    if (empty($this->authAdministrator)) {
      if (($this->request->getParam('controller') !== 'Administrators') || ($this->request->getParam('action') !== 'signIn')) {
        $session->write('Admin.Auth.redirect', $this->request->getPath());

        return $this->redirect([
          'controller' => 'Administrators',
          'action' => 'signIn',
        ]);
      }
    }
  }

  public function beforeRender(EventInterface $event) {
    parent::beforeRender($event);

    $this->set('authAdministrator', $this->authAdministrator);

    $this->viewBuilder()
        ->setLayout('admin');
  }
}

