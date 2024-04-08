from wallet import wallet

import subprocess
import os

from unittest.mock import patch, MagicMock

mock_home=os.getcwd() + "/tests/"
mock_status = 2

@patch('wallet.wallet.os.environ')
@patch('wallet.wallet.subprocess')
@patch('wallet.wallet.sys.exit')
@patch('wallet.wallet.sys.argv', ['launcher', "test,testing", 'runme', 'arg1', 'arg2'])
def test_wallet(mock_exit, mock_run, mock_env):
    environment = {'HOME': mock_home}

    mock_env.__getitem__.side_effect = environment.__getitem__
    mock_env.__setitem__.side_effect = environment.__setitem__

    assert mock_env['HOME'] == mock_home

    sub_status = MagicMock(spec=subprocess.CompletedProcess)
    sub_status.returncode = mock_status

    mock_run.call.return_value = sub_status

    wallet.exec()

    mock_run.call.assert_called_with(['runme', 'arg1', 'arg2'])

    assert environment['HOME'] == mock_home
    assert environment['string'] == 'foo'
    assert environment['number'] == 10

    mock_exit.assert_called_with(mock_status)

    
