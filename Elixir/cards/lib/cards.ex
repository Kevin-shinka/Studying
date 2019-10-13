defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Return a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Joker", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    
    for suit <- suits, value <- values do  
      "#{value} of #{suit}"
    end

  end

  @doc """
    Creates a shuffled deck of playing cards and divides into a hand and the remainder of the deck.
    The `hand_size` argumente indicates how many cards should be in the hand.
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Return a shuffled list of strings based in the argumente `deck` passed.
  """
  def shuffle (deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Return if a card, passed in the argument `hand` exists in the list of strings `deck`.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    Save the list os strings `deck` in a file on `filename` location
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Return the cards of a file locataed in `filename` location
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file doesn't exist"
    end
  end

end
