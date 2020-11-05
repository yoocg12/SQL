if :system.trigger_item = 'b_control.b_cal' then
  if :b_control.b_device_id is null then
    fnd_message.set_string('input device_id'); --forms 메시지 내용 설정.
    fnd_message.show;  --메시지 보여주기.
    
    go_item('b_control.b_device_name'); 
    --db 상에서 관리되는 id 값과 사용자가 보는 name의 item이 다름.    
    --사용자 화면에서 name을 input 하면 id를 가져오는 방식.
    
    raise form_trigger_failure;  --process 처리가 잘못 된 경우 더 이상 진행을 하지 않고 if문을 빠져 나옴.
end if;
