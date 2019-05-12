require 'rails_helper'

describe 'GETリクエスト' do
  it '全てのタスクを取得する' do
    FactoryBot.create_list(:task, 10)
    get '/api/v1/tasks'
    json = JSON.parse(response.body)

    # 200ステータスが返ってきてデータ数も１０
    expect(response.status).to eq(200)
    expect(json['data'].length).to eq(10)
  end

  it '1件のタスクを取得する' do
    task = FactoryBot.create(:task, title: 'get-test')
    get "/api/v1/tasks/#{task.id}"
    json = JSON.parse(response.body)

    # 200ステータスが返ってきて期待したデータのみ返ってくる
    expect(response.status).to eq(200)
    expect(json["data"]["title"]).to eq(task.title)
  end
end

describe 'POSTリクエスト' do
  it '新しいタスクを作成する' do
    valid_params = { title: 'create!' }

    # データが作成されている
    expect { post '/api/v1/tasks', params: { task: valid_params } }.to change(Task, :count)
    expect(response.status).to eq(200)
  end
end

describe 'PUTリクエスト' do
  it 'タスクが編集される' do
    task = FactoryBot.create(:task, title: 'old')

    put "/api/v1/tasks/#{task.id}", params: { task: { title: 'new!' } }
    json = JSON.parse(response.body)

    # 200ステータスかつタイトルが期待通り更新されている
    expect(response.status).to eq(200)
    expect(json["data"]["title"]).to eq('new!')
  end
end

describe 'DELETEリクエスト' do
  it 'タスクが削除される' do
    task = FactoryBot.create(:task)
    
    # 200ステータスかつ期待通り削除されている
    expect { delete "/api/v1/tasks/#{task.id}" }.to change(Task, :count).by(-1)
    expect(response.status).to eq(200)
  end
end
