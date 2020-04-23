describe "Cadatro Detalhar", :detalhes do
  before(:each) do
    visit "/"
    fill_in "login", with: "xxxxxxx"
    fill_in "senha", with: "xxxxxxx"
    find('input[class="btn btn-success"]').click
  end

  it "1.Realizando cadastro.", :cadastrando do
    click_link "Cadastrar"
    fill_in "codigo", with: "22599-57223" #Deve ser trocado pois não pode repetir o código
    fill_in "nome", with: "Teste 10" #Deve ser trocado pois não pode repetir o nome
    find('input[value="1"]').click
    fill_in "cenarios", with: "10"

    click_button "Cadastrar"

    expect(find("#resultado.alert.alert-success")).to have_content "Cadastro realizado com sucesso!"
  end

  it "2.Altarando status", :altera do
    find("#search .search-query").set "10101-01025"
    find("#search .search-query").send_keys :enter
    click_button "detalhar"

    responsaveis = find("#responsavel")
    responsaveis.find("option", text: "Cristiano").select_option

    status = find("#status")
    status.find("option", text: "Em Validação").select_option

    click_button "enviar_status"
    expect(find("#resultado_status")).to have_content "Status Alterado com sucesso!"

    sleep 2
  end
end
