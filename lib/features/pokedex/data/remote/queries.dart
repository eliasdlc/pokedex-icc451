/// Revalidación delta: trae solo los ids vencidos o alterados.
const catalogByIdsQuery =
    r'''
query CatalogByIds($ids: [Int!]!) {
  pokemon(where: {id: {_in: $ids}}, order_by: {id: asc}) {
    ...SummaryFields
  }
}
''' +
    _summaryFragment;

/// Delta del catálogo: la lista de ids remotos (unos 12 KB sin comprimir). Comparada con
/// los ids locales dice exactamente qué falta, incluso si alguien borró una
/// fila a mano. Luego se piden solo esos ids, en lotes.
const catalogIdsQuery = r'''
query CatalogIds {
  pokemon(where: {is_default: {_eq: true}}, order_by: {id: asc}) { id }
}
''';

/// Sonda de salud: la consulta más barata posible.
const healthQuery = r'''
query Health { generation(limit: 1) { id } }
''';

const _summaryFragment = r'''
fragment SummaryFields on pokemon {
  id
  name
  pokemon_species_id
  is_default
  pokemonforms(limit: 1) {
    pokemonformnames(where: {language_id: {_in: [7, 9]}}) { name language_id }
  }
  pokemonspecy {
    generation_id
    evolution_chain_id
    pokemonspeciesnames(where: {language_id: {_in: [1, 7, 9]}}) { name language_id }
  }
  pokemontypes { slot type_id }
  pokemonstats { base_stat stat { name } }
  pokemonabilities { ability_id is_hidden }
  sprite: pokemonsprites { sprites(path: "front_default") }
  artwork: pokemonsprites { sprites(path: "other.official-artwork.front_default") }
}
''';

const detailQuery =
    r'''
query Detail($id: Int!) {
  pokemon(where: {id: {_eq: $id}}) {
    id
    height
    weight
    shiny: pokemonsprites { sprites(path: "other.official-artwork.front_shiny") }
    pokemonabilities {
      is_hidden
      ability {
        id
        name
        abilitynames(where: {language_id: {_in: [7, 9]}}) { name language_id }
        abilityflavortexts(
          where: {language_id: {_in: [7, 9]}}
          order_by: {version_group_id: desc}
          limit: 6
        ) { flavor_text language_id }
      }
    }
    pokemonmoves(where: {move_learn_method_id: {_in: [1, 2, 3, 4]}}) {
      move_id
      version_group_id
      move_learn_method_id
      level
    }
    pokemonspecy {
      varieties: pokemons(order_by: {id: asc}) { ...SummaryFields }
      capture_rate
      is_legendary
      is_mythical
      pokemonegggroups { egggroup { name } }
      pokemonspeciesflavortexts(
        where: {language_id: {_in: [7, 9]}}
        order_by: {version_id: desc}
        limit: 6
      ) { flavor_text language_id }
      evolutionchain {
        id
        pokemonspecies(order_by: {order: asc}) {
          id
          name
          evolves_from_species_id
          pokemonevolutions {
            min_level
            min_happiness
            time_of_day
            evolutiontrigger { name }
            item { name }
          }
        }
      }
    }
  }
  move(
    where: {
      pokemonmoves: {
        pokemon_id: {_eq: $id}
        move_learn_method_id: {_in: [1, 2, 3, 4]}
      }
    }
  ) {
    id
    name
    power
    accuracy
    pp
    type_id
    move_damage_class_id
  }
}
''' +
    _summaryFragment;

const staticDataQuery = r'''
query StaticData {
  type(where: {id: {_lt: 19}}, order_by: {id: asc}) {
    id
    name
    typenames(where: {language_id: {_in: [7, 9]}}) { name language_id }
  }
  typeefficacy(where: {damage_type_id: {_lt: 19}, target_type_id: {_lt: 19}}) {
    damage_type_id
    target_type_id
    damage_factor
  }
  generation(order_by: {id: asc}) { id name region { name } }
  versiongroup(order_by: {order: asc}) { id name order generation_id }
  ability(where: {is_main_series: {_eq: true}}, order_by: {id: asc}) {
    id
    name
    abilitynames(where: {language_id: {_in: [7, 9]}}) { name language_id }
  }
}
''';
