defmodule ElixirCliTalk do
  @moduledoc """
  A simple example program for using escript and command line argument processing
  to create command line utitilies with elixir.

  Usage:
        exilir_cli_talk [options] [strings]
 
      Options:
        -h, [--help]                # Show this help message and quit.
        -g, [--greeting] String     # A salutation, the default is "Hello"
        -a, [--audience] String     # Whom to greet, the default is "World" 
                                    

 
      Description:
        
        Prints out a greeting string, followed by the rest of the command line
        arguments.

  """

  def main(args) do
      args |> parse_args |> process |> cleanup
  end

  def parse_args(args) do
    # Default options
    options = %{ :greeting => "Hello" ,
                 :audience => "World" }

    cmd_opts = OptionParser.parse(args, 
                                  switches: [help: :boolean , greeting: :string, audience: :string],
                                  aliases: [h: :help, g: :greeting, a: :audience])

    case cmd_opts do
      { [ help: true], _, _}   -> :help
      { [], args, [] }         -> { options, args }
      { opts, args, [] }       -> { Enum.into(opts,options), args }
      _                        -> :help
    end

  end

  def process({options, args}) do
    IO.puts options[:greeting]<>" "<>options[:audience]
    IO.puts Enum.join(args," ")

    {options,args}
  end 

  def process(:help) do 
    IO.puts @moduledoc
    System.halt(1)
  end 

  def cleanup({_options,_args}) do
  System.halt(0)
  end 

end

