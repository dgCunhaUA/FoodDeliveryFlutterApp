var restaurants = [
  {
    'id': 1,
    'name': 'Guaros Burguer Bar',
    'address': 'R. Dr. Barbosa de Magalhães 4, 3800-200 Aveiro',
    'fee': 0.4,
    'time_distance': [10, 30],
    'img': 'guaros.webp',
    'stars': 4.8,
    'menu': [
      {
        'name': 'Menu 1',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 8,
        'img': 'guaros.webp',
      },
      {
        'name': 'Menu 2',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 9,
        'img': 'guaros.webp',
      },
      {
        'name': 'Menu 3',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 8,
        'img': 'guaros.webp',
      },
      {
        'name': 'Menu 4',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 8,
        'img': 'guaros.webp',
      },
    ]
  },
  {
    'id': 2,
    'name': 'Wok to Walk (Forum Aveiro)',
    'fee': 0.40,
    'time_distance': [10, 25],
    'img': 'wok.jpeg',
    'stars': 4.4,
    'menu': [
      {
        'name': 'Menu C',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 8,
        'img': 'wok.jpeg',
      },
      {
        'name': 'Menu B',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 9,
        'img': 'wok.jpeg',
      },
      {
        'name': 'Menu C',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 8,
        'img': 'wok.jpeg',
      },
    ]
  },
  {
    'id': 3,
    'name': 'Burguer King (Aveiro)',
    'fee': 2.99,
    'time_distance': [10, 30],
    'img': 'bk.jpeg',
    'stars': 4.6,
    'menu': [
      {
        'name': 'Menu Big King',
        'desc':
            'Se os ingredientes fossem convidados para uma festa não saberíamos qual seria o convidado principal. Cebola frita, bacon crocante, molho barbecue delicioso...fecha a boca... queijo cheddar derretido, suculenta carne nas brasas, tomates frescos e pão levemente torrado completam esta autêntica dança de sabores.',
        'price': 8,
        'img': 'item1.webp',
      },
      {
        'name': 'Menu Whopper',
        'desc':
            'O WHOPPER será sempre o nosso número um. Suculenta carne de vaca grelhada de excelente qualidade, tomate e alface fresca, cebola suave e picles saborosos acompanhados com maionese e ketchup. Não esquecer o pão fofo com sementes, que fazem no seu conjunto um hambúrguer de sabor único e que reconhecerias de olhos fechados.',
        'price': 9,
        'img': 'item2.webp',
      },
      {
        'name': 'Menu King Chicken',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 8,
        'img': 'item3.webp',
      },
      {
        'name': 'Menu Steakhouse',
        'desc': 'Os melhores ingredientes...',
        'price': 8,
        'img': 'item4.webp',
      },
    ]
  },
  {
    'id': 4,
    'name': 'Recanto do Sabor',
    'fee': 2.99,
    'time_distance': [15, 30],
    'img': 'rest1.webp',
    'stars': 3.8,
    'menu': [
      {
        'name': 'Menu 5',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 8,
        'img': 'rest1.webp',
      },
      {
        'name': 'Menu 6',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 9,
        'img': 'rest1.webp',
      },
      {
        'name': 'Menu 7',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 8,
        'img': 'rest1.webp',
      },
      {
        'name': 'Menu 8',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 8,
        'img': 'rest1.webp',
      },
    ]
  },
  {
    'id': 5,
    'name': 'daTerra',
    'fee': 4.20,
    'time_distance': [20, 40],
    'img': 'rest2.webp',
    'stars': 4.9,
    'menu': [
      {
        'name': 'Menu D',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 8,
        'img': 'rest2.webp',
      },
      {
        'name': 'Menu E',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 9,
        'img': 'rest2.webp',
      },
      {
        'name': 'Menu F',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 8,
        'img': 'rest2.webp',
      },
      {
        'name': 'Menu G',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 8,
        'img': 'rest2.webp',
      },
    ]
  },
  {
    'id': 6,
    'name': 'Companhia',
    'fee': 1.99,
    'time_distance': [15, 35],
    'img': 'rest3.webp',
    'stars': 4.1,
    'menu': [
      {
        'name': 'Menu 9',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 12,
        'img': 'rest3.webp',
      },
      {
        'name': 'Menu 10',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 16,
        'img': 'rest3.webp',
      },
      {
        'name': 'Menu 11',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 14,
        'img': 'rest3.webp',
      },
    ]
  },
  {
    'id': 7,
    'name': 'Mr. Pizza',
    'fee': 0.60,
    'time_distance': [10, 20],
    'img': 'rest4.webp',
    'stars': 3.6,
    'menu': [
      {
        'name': 'Menu H',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 12,
        'img': 'rest4.webp',
      },
      {
        'name': 'Menu I',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 9,
        'img': 'rest4.webp',
      },
      {
        'name': 'Menu J',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 11,
        'img': 'rest4.webp',
      },
    ]
  },
  {
    'id': 8,
    'name': 'Food kor\'t',
    'fee': 0.40,
    'time_distance': [5, 15],
    'img': 'rest5.webp',
    'stars': 4.2,
    'menu': [
      {
        'name': 'Menu 12',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 7,
        'img': 'rest5.webp',
      },
      {
        'name': 'Menu 13',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 12,
        'img': 'rest5.webp',
      },
      {
        'name': 'Menu 14',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 11,
        'img': 'rest5.webp',
      },
      {
        'name': 'Menu 15',
        'desc': 'Lorem ipsum dolor sit amet.',
        'price': 10,
        'img': 'rest5.webp',
      },
    ]
  },
];
