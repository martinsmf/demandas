describe "Teste da tela de cadastro da demanda", :emSequencia do
  before(:each) do
    visit "/"
    fill_in "login", with: "xxxxxxxxx"
    fill_in "senha", with: "xxxxxxxxx"
    find('input[class="btn btn-success"]').click
    click_link "Cadastrar"
  end

  it "1.cadastro sem inserir os dados", :campos do
    click_button "Cadastrar"

    expect(find('label[for="codigo"]')).to have_content "Preencha o Código da Demanda!"
    expect(find('label[for="nome"]')).to have_content "Preencha o Nome da Demanda!"
    cenario = find("table tbody tr", text: "Cenários:")
    notificacao = cenario.all("td")[1].text
    expect(notificacao).to eql "Preencha o Número de cenários!"
  end

  it "3.Cadastro sem selecinar o tipo de demanda", :demanda do
    fill_in "codigo", with: "12672-92434"
    fill_in "nome", with: "Teste 05"
    fill_in "cenarios", with: "10"

    click_button "Cadastrar"

    expect(find("#resultado.alert.alert-success")).to have_content "O tipo da demanda deve ser selecinado."
  end

  it "4.Cadastro com sucesso", :sucesso do
    fill_in "codigo", with: "57896-58124" #Deve ser trocado pois não pode repetir o código
    fill_in "nome", with: "Teste 08" #Deve ser trocado pois não pode repetir o nome
    find('input[value="1"]').click
    fill_in "cenarios", with: "10"

    click_button "Cadastrar"

    expect(find("#resultado.alert.alert-success")).to have_content "Cadastro realizado com sucesso!"
  end

  it "5.Limpando os campos", :limpar do
    fill_in "codigo", with: "57896-68124" #Deve ser trocado pois não pode repetir o código
    fill_in "nome", with: "Teste 08" #Deve ser trocado pois não pode repetir o nome
    find('input[value="1"]').click
    fill_in "cenarios", with: "10"

    find("input.btn").click

    expect(find("#codigo")).to have_content ""
    expect(find("#codigo")).to have_content ""
    expect(find("#codigo")).to have_content ""

    #tira um print mostrando que os campos foram limpos
    page.save_screenshot("passou/limpo.png") #if e.exception
  end
end
